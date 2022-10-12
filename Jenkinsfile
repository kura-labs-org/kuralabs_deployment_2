pipeline {
  agent any
   stages {
    stage ('Build') {
      steps {
        sh '''#!/bin/bash
        python3 -m venv test3
        source test3/bin/activate
        pip install pip --upgrade
        pip install -r requirements.txt
        export FLASK_APP=application
        flask run &
        '''
     }
   }
    stage ('test') {
      steps {
        sh '''#!/bin/bash
        source test3/bin/activate
        py.test --verbose --junit-xml test-reports/results.xml
        ''' 
      }
    
      post{
        always {
          junit 'test-reports/results.xml'
        }
       
      }
    }
    stage ('Deploy') {
      agent{label 'awsDeploy'}
      steps {
        sh '''#!/bin/bash
        git clone https://github.com/kura-labs-org/kuralabs_deployment_2.git
        cd ./kuralabs_deployment_2
        cat <<EOF > testing.sh
        #!/bin/bash
        pip install -r requirements.txt
        pip install gunicorn
        python3 -m gunicorn -w 4 application:app -b 0.0.0.0 --daemon
        EOF
        sleep 1
        chmod 777 testing.sh
        sleep 1
        ./testing.sh
        '''
      }
    } 
  }
}
