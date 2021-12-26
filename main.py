import tkinter as tk


WINDOW_HEIGHT = 600
WINDOW_WIDTH = 800
PUMP_Y = WINDOW_HEIGHT // 2
PUMP_X = WINDOW_WIDTH // 2
PUMP_SIZE = 100
PIPE_WIDTH = 50

SENSORS_POSITION_X = 100
SENSORS_POSITION_Y = 20
SENSORS_SIZE_X = 8
SENSORS_SIZE_Y = 1

SENSOR_INPUT_LABELS_PADDING = 30
SENSOR_INPUT_LABEL_X = 60
SENSOR_INPUT_LABELS_X = 0

LAMP_SIZE = 30
LAMP_POSITION = 20

DEFAULT_SENSOR_DATA: float = 4.0


def refresh_sensors():
    for index, sensor in enumerate(sensors):
        sensor_data: str = sensor.get()
        if sensor_data.replace('.', '').isdigit():
            sensor_data_int = float(sensor_data)
            if sensor_data_int <= 20:
                sensors_data[index] = sensor_data_int

        sensors_labels[index].config(text=str(sensors_data[index]))

    avg_pressure_before = (sensors_data[0] + sensors_data[1]) / 2
    avg_pressure_after = (sensors_data[2] + sensors_data[3]) / 2

    avg_pressure_before_label.config(text=avg_pressure_before)
    avg_pressure_after_label.config(text=avg_pressure_after)

    primary_pump_on = avg_pressure_before < 10.8
    extra_pump_on = abs(avg_pressure_before - avg_pressure_after) > 0.8

    primary_pump_light.config(
        bg='green' if primary_pump_on else 'red'
    )
    extra_pump_light.config(
        bg='green' if extra_pump_on else 'red'
    )


def create_static(canvas):
    # Труба
    canvas.create_rectangle(
        0,
        WINDOW_HEIGHT // 2 + PIPE_WIDTH,
        WINDOW_WIDTH,
        WINDOW_HEIGHT // 2 - PIPE_WIDTH,
        fill='grey',
        width=2,
    )

    # Основной насос
    canvas.create_rectangle(
        PUMP_X - PUMP_SIZE,
        PUMP_Y - PUMP_SIZE,
        PUMP_X + PUMP_SIZE,
        PUMP_Y,
        fill='grey',
        width=2,
    )

    # Резервный насос
    canvas.create_rectangle(
        PUMP_X - PUMP_SIZE,
        PUMP_Y + PUMP_SIZE,
        PUMP_X + PUMP_SIZE,
        PUMP_Y,
        fill='grey',
        width=2,
    )

    # Подписи для полей ввода
    for index in range(4):
        tk.Label(
            master=canvas,
            text=f'Датчик {index}'
        ).place(
            x=SENSOR_INPUT_LABELS_X,
            y=index * SENSOR_INPUT_LABELS_PADDING,
        )

    # Кнопка Обновить
    button = tk.Button(canvas, text='Обновить', command=refresh_sensors)
    button.place(
        x=SENSOR_INPUT_LABELS_X,
        y=SENSOR_INPUT_LABELS_PADDING * 4
    )


if __name__ == '__main__':
    sensors_data = [DEFAULT_SENSOR_DATA for _ in range(4)]
    
    window = tk.Tk()
    window.title('Нефтепровод')
    window.geometry(f'{WINDOW_WIDTH}x{WINDOW_HEIGHT}')

    canvas = tk.Canvas(
        master=window,
        bg='aqua',
    )
    canvas.pack(
        fill=tk.BOTH,
        expand=True,
    )

    # Вынес создание некоторых статических элементов в метод...
    create_static(canvas)

    # Создание полей ввода для сенсоров
    sensors = [tk.Entry(canvas, name=f'sensor_{index}') for index in range(4)]

    for index, sensor in enumerate(sensors):
        sensor.place(
            x=SENSOR_INPUT_LABEL_X,
            y=index * SENSOR_INPUT_LABELS_PADDING,
        )

    # Поля для вывода показаний датчиков
    sensors_labels = [
        tk.Label(
            master=canvas,
            height=SENSORS_SIZE_Y,
            width=SENSORS_SIZE_X,
            bg='white',
        )
        for _ in range(4)
    ]
    sensors_labels[0].place(
        x=PUMP_X - PUMP_SIZE - SENSORS_POSITION_X - SENSORS_SIZE_X * 8,
        y=PUMP_Y + SENSORS_POSITION_Y,
    )
    sensors_labels[1].place(
        x=PUMP_X - PUMP_SIZE - SENSORS_POSITION_X - SENSORS_SIZE_X * 8,
        y=PUMP_Y - SENSORS_POSITION_Y - SENSORS_SIZE_Y * 10,
    )
    sensors_labels[3].place(
        x=PUMP_X + PUMP_SIZE + SENSORS_POSITION_X,
        y=PUMP_Y + SENSORS_POSITION_Y + SENSORS_SIZE_Y,
    )
    sensors_labels[2].place(
        x=PUMP_X + PUMP_SIZE + SENSORS_POSITION_X,
        y=PUMP_Y - SENSORS_POSITION_Y - SENSORS_SIZE_Y * 10,
    )

    # Лампа основного насоса
    primary_pump_light = tk.Frame(
        master=canvas,
        width=LAMP_SIZE,
        height=LAMP_SIZE,
    )
    primary_pump_light.place(
        x=PUMP_X + LAMP_POSITION,
        y=PUMP_Y - LAMP_SIZE - LAMP_POSITION,
    )

    # Лампа резервного насоса
    extra_pump_light = tk.Frame(
        master=canvas,
        width=LAMP_SIZE,
        height=LAMP_SIZE,
    )
    extra_pump_light.place(
        x=PUMP_X + LAMP_POSITION,
        y=PUMP_Y + LAMP_POSITION,
    )

    # Поле для отображения среднего давления ДО насосов
    avg_pressure_before_label = tk.Label(
        master=canvas,
        height=SENSORS_SIZE_Y,
        width=SENSORS_SIZE_X,
        bg='white',
    )
    avg_pressure_before_label.place(
        x=PUMP_X - PUMP_SIZE - 85,
        y=PUMP_Y,
    )
    # Поле для отображения среднего давления ПОСЛЕ насосов
    avg_pressure_after_label = tk.Label(
        master=canvas,
        height=SENSORS_SIZE_Y,
        width=SENSORS_SIZE_X,
        bg='white',
    )
    avg_pressure_after_label.place(
        x=PUMP_X + PUMP_SIZE + 20,
        y=PUMP_Y,
    )
    refresh_sensors()
    window.mainloop()
