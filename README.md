🚀 Guía de instalación y ejecución del proyecto

Este repositorio contiene:

🗄️ Base de datos

🔌 API (Node.js)

📱 Frontend (Flutter)


Sigue estos pasos para ejecutar el proyecto correctamente en tu computador.

1. Clonar el repositorio
2. git clone <URL_DEL_REPOSITORIO>

abre el proyevto en un entorno de desarrollo ( VS CODE)

3. Instalar dependencias
🔹 API
Dirígete a la carpeta de la API e instala las dependencias: 

cd back_end ---->
npm install

🔹 Frontend (Flutter)
Dirígete a la carpeta del frontend:

cd login_app ------>
flutter pub get

3. Configurar la base de datos
Crea una base de datos en tu gestor (xampp/phpAdmin)

DB_NAME=  app_crud <-------- asi la tienes que nombrar

Importa el archivo .sql incluido en el repositorio

⚙️ 4. Configurar variables de entorno

Ve a la carpeta de la API:

cd back_end

Crea un archivo llamado .env he ingresa estas variables

PORT=3000

HOST=0.0.0.0

DB_HOST=localhost

DB_USER=root

DB_PASSWORD=

DB_PORT=3306

DB_DIALECT=mysql

DB_NAME=app_crud

JWT_SECRET=jwt_secre

JWT_EXPIRES_IN=7d

NODE_ENV=development



▶️ 5. Ejecutar el proyecto

🔹 Ejecutar la API

npm run dev


🔹 Ejecutar el Frontend
En otra terminal:

cd front

flutter run


🧪 Opción 2 (Ejecución alternativa)
Puedes ejecutar ambos servicios en paralelo abriendo dos terminales:

Terminal 1 → API

cd back_end

npm run dev


Terminal 2 → Frontend

cd login_app

flutter run

✅ Notas importantes

Asegúrate de tener instalado:

Node.js

Flutter

Un gestor de base de datos

Verifica que el archivo .env esté correctamente configurado

¡Y listo! 🎉 Ahora deberías poder ejecutar el proyecto sin problemas.
