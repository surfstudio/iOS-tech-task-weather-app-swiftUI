@Library('surf-lib@version-2.0.0-SNAPSHOT') // https://bitbucket.org/surfstudio/jenkins-pipeline-lib/
import ru.surfstudio.ci.pipeline.pr.PrPipelineiOS
import ru.surfstudio.ci.stage.StageStrategy
import ru.surfstudio.ci.CommonUtil

//init
def pipeline = new PrPipelineiOS(this)
pipeline.init()

def projectJiraId = "IDPT"
def serverUrl = "http://stage.ps.surfstudio.ru/data_consumer"
def fastlaneReport = 'fastlane/test_output/report.html'
def jscpdReport = "./report/jscpd-report.json"

//customization
pipeline.getStage(pipeline.UNIT_TEST).body = {
	CommonUtil.shWithRuby(this, "make test")
	junit 'fastlane/test_output/report.junit'
	archiveArtifacts artifacts: fastlaneReport
	CommonUtil.shWithRuby(this, "make analytics_tests projectJiraId=${projectJiraId} serverUrl=${serverUrl} report=${fastlaneReport}")
}

pipeline.getStage(pipeline.STATIC_CODE_ANALYSIS).body = {
	CommonUtil.shWithRuby(this, "make lint")
	CommonUtil.shWithRuby(this, "make analytics_duplicates projectJiraId=${projectJiraId} serverUrl=${serverUrl} report=${jscpdReport}")
	archiveArtifacts artifacts: 'report/jscpd-report.html'
	recordIssues enabledForFailure: true, tool: cpd(pattern: 'report/jscpd-report.xml')
}

pipeline.stages.add(2, pipeline.stage("Analytics Collecting", StageStrategy.FAIL_WHEN_STAGE_ERROR) {
	CommonUtil.shWithRuby(this, "make analytics_pods projectJiraId=${projectJiraId} serverUrl=${serverUrl}")
})

pipeline.getStage(pipeline.STATIC_CODE_ANALYSIS).strategy = StageStrategy.FAIL_WHEN_STAGE_ERROR
pipeline.getStage(pipeline.UNIT_TEST).strategy = StageStrategy.FAIL_WHEN_STAGE_ERROR
pipeline.getStage(pipeline.INSTRUMENTATION_TEST).strategy = StageStrategy.SKIP_STAGE

//run
pipeline.run()
