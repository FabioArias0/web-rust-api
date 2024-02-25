# Etapa de construccion
FROM rust:1.69-buster as builder

WORKDIR /app

# Aceptar argumento de construccion
ARG DATABASE_URL

ENV DATABASE_URL=$DATABASE_URL

COPY . . 

RUN cargo build --release

# Etapa de produccion
FROM debian:buster-slim

WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/web-rust-api .

CMD ["./web-rust-api"]