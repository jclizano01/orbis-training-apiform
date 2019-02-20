pipeline {
    agent any
    stages {
        stage('BIenvenido') {
            steps {
                echo 'HOla Mundo desde jenkins'
            }
        }
    }
}

parameters {
    booleanParam(name: 'DEPLOY_STACK', defaultValue: false, description: 'Desplegar Stack CloudFormation')
    booleanParam(name: 'DELETE_STACK', defaultValue: false, description: 'Eliminar Stack CloudFormation')
    booleanParam(name: 'UPDATE_FUNCTION_LAMBDA', defaultValue: false, description: 'Actualizar funcion Lambda')
}