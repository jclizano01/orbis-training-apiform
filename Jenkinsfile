def fnSteps = evaluate readTrusted("deploy/steps.groovy")

pipeline {
    agent any
    stages {
        stage('Set Config') {
            steps {
                script {
                    config = fnSteps.configs("${JENKINS_ENV}", params.RUNTEST, params.BANK)
                    withEnv(config) { 
                        echo "variables de ambiente"
                        fnSteps.showEnviroment(config)
                    }
                }
            }
        }
        stage('Segundo Paso') {
            steps {
                echo 'ejecucion del segundo paso de jenkinsfile'
            }
        }
        stage('Tercer Paso') {
            steps {
                echo 'ejecucion del segundo paso de jenkinsfile'
            }
        }
    }
}

parameters {
    booleanParam(
        name: 'DEPLOY_STACK', 
        defaultValue: false, 
        description: 'Desplegar Stack CloudFormation'
    )
    booleanParam(
        name: 'DELETE_STACK', 
        defaultValue: false, 
        description: 'Eliminar Stack CloudFormation'
    )
    booleanParam(
        name: 'UPDATE_FUNCTION_LAMBDA', 
        defaultValue: false, 
        description: 'Actualizar funcion Lambda'
    )
    choice(
        name: 'RUNTEST',
        choices:["consultar","Pagar","Extornar","Operación"],
        description: 'Ejecuta el test selecionado'
    )
    choice(
        name: 'BANK',
        choices:["BCP","BBVA","FC","SKB","WU","IBK","BANBIF"],
        description: 'Banco que ejecutra el test')
}