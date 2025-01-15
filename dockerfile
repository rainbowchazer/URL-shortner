# Используем официальный образ Go в качестве базового
FROM golang:1.23.4

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Устанавливаем переменную окружения
ENV CONFIG_PATH=url_short/config/local.yaml

# Копируем go.mod и go.sum для ускоренной сборки зависимостей
COPY go.mod go.sum ./

COPY config/local.yaml ./url_short/config/

# Загружаем зависимости
RUN go mod tidy

# Копируем весь проект в рабочую директорию контейнера
COPY . .

# Сборка проекта, указывая путь к main.go (например, /app/src)
RUN go build -o main ./cmd/url-short


# Указываем команду для запуска контейнера
CMD ["./main"]
