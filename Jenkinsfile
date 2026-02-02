// Uses Declarative syntax to run commands inside a container.
pipeline {
  agent {
    kubernetes {
      agentContainer 'jnlp'
      agentInjection true
      cloud 'the-hard-way'
      //defaultContainer 'helm'
      //inheritFrom 'helm'
      yamlFile  'jenkins.yaml'
      namespace 'jenkins'
    }
  }
  stages {
    stage('test') {
      steps {
        node('') {
          container('') {
            timestamps {
              ansiColor('xterm') {
                  echo("Output environment")
                  sh("env|sort")
                  echo("this is the httpie step")
                  sh("python -m venv .")
                  sh("bin/pip install -U pip httpie")
                  sh("bin/http --verbose get https://google.com")
                  sh("bin/http --verbose get https://jenkins.breeze-blocks.net")
                  sh("env|sort")
              }
            }
          }
        }
      }
    }
    stage("lint") {
      steps {
        node('helm') {
          container('helm') {
            timestamps {
              ansiColor('xterm') {
                echo("lint the helm chart")
                sh("python -m venv .")
                sh("bin/pip install -U pip httpie")
                sh("bin/http --verbose get https://jenkins.breeze-blocks.net")
                sh("env|sort")
                echo("lint the helm chart on ${env.BRANCH_NAME}")
                checkout scm
                sh("""
                  for i in " " values.yaml comms.values.yaml thw.values.yaml; do
                    helm lint . -f "$i"
                  done
                """)
              }
            }
          }
        }
      }
    }
    stage("helm unittests") {
      steps {
        node('helm') {
          container('helm') {
            timestamps {
              ansiColor('xterm') {
                sh("python -m venv .")
                sh("bin/pip install -U pip httpie")
                sh("http --verbose get https://jenkins.breeze-blocks.net")
                echo("Run unittests")
                sh("helm unittest --color -u -f 'tests/*.yaml' .")
                echo("Save report for ${env.BRANCH_NAME}")
                sh("helm unittest -u -t JUnit -o results-${env.BRANCH_NAME}.xml .")
                junit("results-${env.BRANCH_NAME}.xml")
              }
            }
          }
        }
      }
    }
  }
}
