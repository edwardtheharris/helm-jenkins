// Uses Declarative syntax to run commands inside a container.
pipeline {
  agent {
    kubernetes {
      defaultContainer 'helm'
      yamlFile  'jenkins.yaml'
      retries 2
    }
  }
  stages {
    stage('checkout') {
          steps {
  timestamps {
    withKubeConfig(
      caCertificate: '',
      clusterName: 'the-hard-way',
      contextName: 'the-hard-way', credentialsId: 'the-hard-way-kubeconfig', namespace: 'jenkins',
      restrictKubeConfigAccess: false, serverUrl: 'https://192.168.5.97:6443') {

            checkout(scm)
          }
        }
          }
    }
        stage("lint") {
          steps {
            timestamps {
              echo("lint the helm chart on ${env.BRANCH_NAME}")
              sh("helm lint .")

              }
          }
        }
        stage("helm unittests") {
          steps {
            timestamps {
              container("helm") {
                git(branch: 'main', url: 'https://github.com/helm-unittest/helm-unittest.git')

                echo("Install unittest plugin")
                sh("helm plugin install ./helm-unittest")

                echo("Run unittests")
                sh("helm unittest -u -f 'tests/*.yaml' .")

                echo("Save report for ${env.BRANCH_NAME}")
                sh("helm unittest -u -t JUnit -o results-${env.BRANCH_NAME}.xml .")
                junit("results-${env.BRANCH_NAME}.xml")
              }
            }
          }
        }
      }
    }
