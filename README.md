# Guía de instalación y ejecución del proyecto


1. **Descargar el proyecto**
   - Entra a `https://github.com/ROBINALMONACID/Taller-quiz-1`, pulsa el botón verde **Code** y elige **Download ZIP**.
   - Descomprime el ZIP en la carpeta que quieras y abre esa carpeta en tu terminal.

2. **Configurar la base de datos MySQL**
   - Asegúrate de tener MySQL instalado y en ejecución.
   - Crea la base de datos `app_crud` (puedes usar MySQL Workbench, phpMyAdmin o la CLI: `CREATE DATABASE app_crud;`).
   - Importa el archivo SQL incluido: `BASE DE DATOS/app_crud.sql`. Por ejemplo:
     ```powershell
     mysql -u root -p app_crud < "BASE DE DATOS\\app_crud.sql"
     ```
   - Si usas otro usuario/host, ajusta el comando y recuerda la contraseña.

3. **Arrancar el backend (Node.js)**
   - Entra a `back_end`:
     ```powershell
     cd back_end
     npm install
     npm run dev
     ```
     (o `npm start` para la versión sin reinicios automáticos).
   - El backend escucha en `http://localhost:<PORT>` según el `.env`.

4. **Arrancar la app Flutter**
   - Desde la raíz del proyecto ve a `login_app`:
     ```powershell
     cd login_app
     flutter pub get
     flutter run
     O
     flutter run -d chrome
     ```
   - `flutter run` detecta el dispositivo disponible (emulador o teléfono). Si prefieres un destino concreto, agrega `-d chrome` o `-d windows` según lo que tengas.

5. **Notas finales**
   - Si algo falla, revisa `flutter doctor`, asegúrate de que el servidor esté activo y que la base de datos exista con los datos de ejemplo.


   Verifica que el archivo .env esté correctamente configurado
  ¡Y listo! 🎉 Ahora deberías poder ejecutar el proyecto sin problemas.
