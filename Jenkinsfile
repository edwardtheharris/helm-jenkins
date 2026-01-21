// Uses Declarative syntax to run commands inside a container.
pipeline {
  agent {
    kubernetes {
      cloud 'the-hard-way'
      //yamlFile  'jenkins.yaml'
      namespace 'jenkins'
    }
  }
  stages {
    stage('test') {
      steps {
        node("${env.POD_LABEL}") {
          container('jnlp') {
            ansiColor('xterm') {
              sh("helm create test")
            }
          }
        }
      }
    }
    stage("lint") {
      steps {
        node("${env.POD_LABEL}") {
          container("jnlp") {
            ansiColor('xterm') {
              echo("lint the helm chart on ${env.BRANCH_NAME}")
              sh(script: '''
                #!/bin/bash
                for i in *values.yaml; do
                  helm lint . -f $i
                done
              ''', label: "lint the chart")
            }
          }
        }
      }
    }
    stage("helm unittests") {
      steps {
        node("${env.POD_LABEL}") {
          container('jnlp') {
            ansiColor('xterm') {
              echo("Run helm unittests for ${env.BRANCH_NAME}")
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
