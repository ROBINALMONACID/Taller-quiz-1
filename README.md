Guía de instalación y ejecución del proyecto
# Taller Quiz 1

Guía sencilla para descargar, configurar e iniciar el proyecto en cualquier PC.

## 1. Descargar el proyecto
- Entra a `https://github.com/ROBINALMONACID/Taller-quiz-1`, haz clic en **Code** y descarga el ZIP (o clónalo con `git clone https://github.com/ROBINALMONACID/Taller-quiz-1.git`).
- Descomprime el ZIP o entra en la carpeta recién clonada con tu terminal/PowerShell.

## 2. Instalar dependencias
- Abre una terminal en `back_end`:
  ```powershell
  cd back_end
  npm install
  ```
- En otra terminal, ve a `login_app`:
  ```powershell
  cd login_app
  flutter pub get
  ```
  (Necesitas tener instalado Flutter y un canal `stable` válido.)

## 3. Configurar la base de datos MySQL
- Asegúrate de tener MySQL funcionando.
- Crea la base de datos `app_crud` (puedes usar MySQL Workbench, phpMyAdmin o la CLI):
  ```sql
  CREATE DATABASE app_crud;
  ```
- Importa el archivo SQL incluido:
  ```powershell
  mysql -u root -p app_crud < "BASE DE DATOS\\app_crud.sql"
  ```
  Ajusta `-u`/`-p` si usas otro usuario o contraseña.

## 4. Variables de entorno
- Copia `back_end/.env.example` como `.env` y completa los valores:
  ```
  PORT=3000
  DB_HOST=localhost
  DB_USER=root
  DB_PASSWORD=
  DB_PORT=3306
  DB_DIALECT=mysql
  DB_NAME=app_crud
  JWT_SECRET=jwt_secret_key
  JWT_EXPIRES_IN=7d
  NODE_ENV=development
  ```
- Si necesitas otro puerto o host, ajústalo aquí.

## 5. Ejecutar el backend
1. En la carpeta `back_end`:
   ```powershell
   npm run dev
   ```
   (usa `npm start` si no quieres reinicio automático.)
2. El servidor quedará escuchando en `http://localhost:<PORT>` según tu `.env`.

## 6. Ejecutar el frontend Flutter
1. Abre otra terminal en `login_app`:
   ```powershell
   flutter run
   ```
2. Si prefieres un dispositivo específico, usa `flutter run -d chrome` o `-d windows`.

## 7. Notas finales
- Mantén el `.env` real solo en tu máquina; no lo subas al repositorio.
- Revisa `flutter doctor` si Flutter no detecta ningún dispositivo.
- Si el backend no responde, confirma que MySQL está activo y la base de datos `app_crud` contiene los datos importados.
- Puedes ejecutar backend y frontend en paralelo con dos terminales abiertas.
