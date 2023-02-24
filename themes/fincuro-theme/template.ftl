<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
		<script src="https://d2q4ijjoy71h8b.cloudfront.net/uploads/540c0cd2-7a31-415f-a7ac-de8755a97ac7/original/vue.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/vee-validate/3.4.5/vee-validate.full.min.js"></script>
</head>

<body class="${properties.kcBodyClass!}">
	<div class="mobile-decoration d-block d-md-none"></div>
  <div class="${properties.kcLoginClass!} container">
		<!-- row -->
		<div class="row">
			<div class="col pb-4 pb-md-0">
				<div class="">
					<div id="kc-content" class="col-12 test-theme px-4 px-md-0">
						<div id="kc-content-wrapper" class="col-12">
							<#-- App-initiated actions should not see warning messages about the need to complete the action -->
							<#-- during login.                                                                               -->
							<#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
									<div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if>">
											<div class="pf-c-alert__icon">
													<#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
													<#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
													<#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
													<#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
											</div>
													<span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
									</div>
							</#if>
							<#nested "form">

								<#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
										<form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
												<div class="${properties.kcFormGroupClass!}">
														<input type="hidden" name="tryAnotherWay" value="on"/>
														<a href="#" id="try-another-way"
															onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
												</div>
										</form>
								</#if>

							<#if displayInfo>
									<div class="${properties.kcSignUpClass!}">
											<div class="${properties.kcInfoAreaWrapperClass!}">
													<#nested "info">
											</div>
									</div>
							</#if>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--/ row -->
  </div>
	<#nested "scripts">
</body>
</html>
</#macro>
