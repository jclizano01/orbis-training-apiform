pipeline {
    agent any
    stages {
        stage('BIenvenido') {
            steps {
                echo 'Hola mundo desde jenkins'
            }
        }
        stage('Segundo Paso') {
            steps {
                echo 'ejecucion del segundo paso de jenkinsfile'
            }
        }
    }
}

parameters {
    booleanParam(name: 'DEPLOY_STACK', defaultValue: false, description: 'Desplegar Stack CloudFormation')
    booleanParam(name: 'DELETE_STACK', defaultValue: false, description: 'Eliminar Stack CloudFormation')
    booleanParam(name: 'UPDATE_FUNCTION_LAMBDA', defaultValue: false, description: 'Actualizar funcion Lambda')
}