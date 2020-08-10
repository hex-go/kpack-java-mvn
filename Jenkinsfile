@Library('icosqa-pipeline-lib@master') import org.com.DitSteps
node{
    acme.setJobName("$JOB_NAME")
    acme.init(BUILD_NUMBER)
    def dit = new org.com.DitSteps(this)
    stage('Check out') {
       checkout scm
    }
    dit.javaWorkFlow acme
}