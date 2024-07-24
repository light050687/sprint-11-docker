# Используем официальный образ Golang для сборки приложения
FROM golang:1.22 AS builder

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем go.mod и go.sum для установки зависимостей
COPY go.mod go.sum ./

# Устанавливаем зависимости
RUN go mod download

# Копируем исходный код
COPY *.go ./
COPY tracker.db ./

# Используем образ linux
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /tracker

# Указываем команду для запуска приложения
CMD ["./tracker"]