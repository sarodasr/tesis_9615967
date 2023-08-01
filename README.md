# MANUAL DE LA IMPLEMENTACIÓN DE TERRAFORM COMO HERRAMIENTA BÁSICA, PARA EL MEJORAMIENTO DE LA ADMINISTRACIÓN DE SEGURIDAD EN LAS PLATAFORMAS AWS

Este repositorio cuenta con los archivos que contienen la configuración realizada como material de apoyo para el desarrollo del trabajo de graduación del estudiante de la carrera de Ingeniería en Ciencias y Sistemas de la Facultad de Ingenieria en la Universidad de San Carlos de Guatemala. Dicho trabajo fue realizado por el estudiante Sergio Alejandro Rodas Romero con número de carné 9615967

## Índice general
* [Tecnología a utilizar](#herramientas-a-utilizar)
* [Contenido](#contenido)
* [Instrucciones](#instrucciones)

## Herramientas a utilizar
En este proyecto fueron utilizadas las siguientes herramientas:
* Software Terraform open source, versión 1.0.4 para Windows x64.
* Terraform para windows con tecnología amd64, versión 4.67
* Visual Studio Code para Windows, versión 1.80.1

## Contenido
Este repositorio cuenta con los siguientes apartados:
* main.tf: Archivo inicial de configuración, contiene datos de AWS.
* cifrado.tf: Archivo donde se configura el apartado de protección de datos en tránsito, es decir, llaves de cifrado de bucket.
* iam_roles.tf: Archivo que contiene la configuración de roles AWS.
* security_groups.tf: Archivo que contiene la configuración de grupos de seguridad.
* variables.tf: Archivo que especifica las variables vistas en la sección que gestiona variables sensibles.
* vulnerabilidades.tf: Archivo que especifica la forma para trabajar con AWS SecurityHub

## Instrucciones
* Descargar el repositorio a un directorio local.
* Modificar las credenciales de AWS por unas propias.
* Ejecutar el comando "terraform init"
* Verificar que se haya configurado el proveedor correctamente.
* Ejecutar el comando "terraform fmt" para evitar caracteres inválidos.
* Ejecutar el comando "terraform validate" para verificar que la configuración es correcta. Esto validará que las credenciales de AWS sean correctas.
* Ejecutar el comando "terraform plan" para crear un nuevo archivo de estado.
* Ejecutar el comando "terraform apply" para desplegar la infraestructura.
