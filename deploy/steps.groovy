def showEnviroment(def config) {
    echo "Enviroment:"
    for(e in config){
        echo "--> ${e}"
    }
}

def getRegions(def enviroment) {
  def REGIONS = [
      dev:'eu-west-1',
      pre:'us-west-2',
      prod:'us-east-1'
  ]
  return REGIONS[enviroment]
}

def configs(def enviroment, def runtest, def bank) {
  region = getRegions(enviroment)
  def config = [
    "ENV=${enviroment}",
    "DEPLOY_REGION=${region}",
    "INFRA_BUCKET=infraestructura.${enviroment}",
    "SLACK_CHANNEL=pe-testing",
    "ACCOUNT_ID=929226109038",
    "MEMORY_SIZE=128",
    "TEST_ENV=${enviroment}",
    "STORAGE=s3",
    "BANK=${bank}",
    "CLICK_OPTION=${runtest}"
  ]

  return config
}

def construirImagen() {
  // sh 'make build'
  // sh 'make create.venv'
  // sh 'make install.libs'
  // sh 'make package.function'
  // sh 'make upload.function.bucket'
  // sh 'make stack.deploy'
  echo "hola desde construirImagen"
}

return this