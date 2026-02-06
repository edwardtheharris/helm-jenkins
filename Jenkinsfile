// Uses Declarative syntax to run
/*  agent {
    kubernetes {
      cloud 'the-hard-way'
      yamlFile  'jenkins.yaml'
      namespace 'jenkins'
    }
  } */
stage('test') {
  env.POD_LABEL="helm"
  // podTemplate(agentContainer: 'helm', cloud: 'the-hard-way',
  //             containers: [
  //             containerTemplate(alwaysPullImage: true, command: '/usr/local/bin/jenkins-agent',
  //                     image: 'ghcr.io/edwardtheharris/helm-jenkins/helm:0.0.2-01', livenessProbe: containerLivenessProbe(execArgs: '',
  //                     failureThreshold: 0, initialDelaySeconds: 0, periodSeconds: 0,
  //                     successThreshold: 0, timeoutSeconds: 0),
  //             name: 'helm', resourceLimitCpu: '', resourceLimitEphemeralStorage: '', resourceLimitMemory: '',
  //             resourceRequestCpu: '', resourceRequestEphemeralStorage: '',
  //             resourceRequestMemory: '', ttyEnabled: true,
  //             workingDir: '/home/jenkins/agent')], label: 'helm',
  //             name: 'helm', namespace: 'jenkins') {
    node("${env.POD_LABEL}") {
      gitHubPRStatus(githubPRMessage('${GITHUB_PR_COND_REF} run started'))
      container('helm') {
        withKubeConfig(caCertificate: '', clusterName: 'the-hard-way', contextName: 'kubernetes-admin@the-hard-way', credentialsId: 'kubeconfig-the-hard-way', namespace: 'jenkins', restrictKubeConfigAccess: false, serverUrl: 'https://192.168.5.97:6443') {
          ansiColor('xterm') {
            sh("helm create helm-jenkins")
            tar(archive: true, compress: false, defaultExcludes: false,
                dir: 'helm-jenkins', exclude: '',
                file: "${env.JOB_NAME}.${env.BUILD_NUMBER}.tar", glob: '',
                overwrite: false)
            sh("command -v kubectl")
            sh("kubectl cluster-info")
          }
      }
    }
  // }
  }
}
stage("lint") {
  podTemplate(agentContainer: 'helm', cloud: 'the-hard-way',
              containers: [
              containerTemplate(alwaysPullImage: true, command: '/usr/local/bin/jenkins-agent',
                      image: 'ghcr.io/edwardtheharris/helm-jenkins/helm:0.0.2-01', livenessProbe: containerLivenessProbe(execArgs: '',
                      failureThreshold: 0, initialDelaySeconds: 0, periodSeconds: 0,
                      successThreshold: 0, timeoutSeconds: 0),
              name: 'helm', resourceLimitCpu: '', resourceLimitEphemeralStorage: '', resourceLimitMemory: '',
              resourceRequestCpu: '', resourceRequestEphemeralStorage: '',
              resourceRequestMemory: '', ttyEnabled: true,
              workingDir: '/home/jenkins/agent')], label: 'helm',
              name: 'helm', namespace: 'jenkins') {
    node("${env.POD_LABEL}") {
      container("helm") {
        ansiColor('xterm') {
            echo("lint the helm chart on ${env.BRANCH_NAME}")
            checkout scm
            sh(script: '''
              #!/bin/bash
              for i in thw.values.yaml values.yaml; do
                helm lint . -f $i
              done
            ''', label: "lint the chart")
          }
        }
      }
  }
}
stage("helm unittests") {
  podTemplate(agentContainer: 'helm', cloud: 'the-hard-way',
              containers: [
              containerTemplate(alwaysPullImage: true, command: '/usr/local/bin/jenkins-agent',
                      image: 'ghcr.io/edwardtheharris/helm-jenkins/helm:0.0.2-01', livenessProbe: containerLivenessProbe(execArgs: '',
                      failureThreshold: 0, initialDelaySeconds: 0, periodSeconds: 0,
                      successThreshold: 0, timeoutSeconds: 0),
              name: 'helm', resourceLimitCpu: '', resourceLimitEphemeralStorage: '', resourceLimitMemory: '',
              resourceRequestCpu: '', resourceRequestEphemeralStorage: '',
              resourceRequestMemory: '', ttyEnabled: true,
              workingDir: '/home/jenkins/agent')], label: 'helm',
              name: 'helm', namespace: 'jenkins') {
    parallel helm: {
      node("${env.POD_LABEL}") {
        container('helm') {
          ansiColor('xterm') {
            checkout scm
            echo("Run helm unittests for ${env.BRANCH_NAME}")
            sh("helm unittest --color -u -f 'tests/*.yaml' .")
          }
        }
        container('helm') {
          ansiColor('xterm') {
            checkout scm
            echo("Save report for ${env.BRANCH_NAME}")
            sh("helm unittest -u -t JUnit -o results-${env.BRANCH_NAME}.xml .")
            junit("results-${env.BRANCH_NAME}.xml")
          }
        }
        container('helm') {
          ansiColor('xterm') {
            checkout scm
            echo("Publish report for ${env.BRANCH_NAME}")
            githubPRComment(comment: githubPRMessage(sh("helm unittest --color -u -f 'tests/*yaml' .")))
          }
        }
      }
    }
  }
}
stage("docker build and push") {
  withDockerContainer('ghcr.io/edwardtheharris/helm-jenkins:docker:0.0.2-00') {
    sh("docker ps")    // some block
  }
}
