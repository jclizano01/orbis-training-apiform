def showEnviroment(def config) {
    echo "Enviroment:"
    for(e in config){
        echo "--> ${e}"
    }
}

return this