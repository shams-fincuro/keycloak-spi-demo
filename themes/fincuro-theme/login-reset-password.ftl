<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
    <header>
      <p>header here</p>
    </header>
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <validation-observer
          ref="formularioRecovery"
					v-slot="{invalid}">
					<form id="kc-reset-password-form" action="${url.loginAction}" method="post">
							<Validation-provider
									name="email"
									rules="required|email"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!}"
									tag="div">
									
									<label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}*<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}*<#else>${msg("email")}*</#if></label>
									<#if auth?has_content && auth.showUsername()>
											<input type="text" v-model="username" id="username" name="username" class="${properties.kcInputClass!}" autofocus value="${auth.attemptedUsername}" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" maxlength="${properties.kcEmailMaxLength!}"/>
									<#else>
											<input type="text" v-model="username" id="username" name="username" class="${properties.kcInputClass!}" autofocus aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" maxlength="${properties.kcEmailMaxLength!}"/>
									</#if>

									<#if messagesPerField.existsError('username')>
											<span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
																	${kcSanitize(messagesPerField.get('username'))?no_esc}
											</span>
									</#if>
									<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
											{{ errors[0] }}
									</span>
							</Validation-provider>
							<div class="${properties.kcFormGroupClass!} pt-1">
									<div id="kc-form-buttons">
											<input @click="sendRecoveryGTM()" :disabled="invalid" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg('doSubmit')}"/>
									</div>

									<div id="kc-form-options">
											<div class="${properties.kcFormOptionsWrapperClass!}">
													<span class="mt-4 text-center">Go back to <a href="${url.loginUrl}" class="btn-back-to-login">${kcSanitize(msg("Sign in"))?no_esc}</a></span>
											</div>
									</div>
							</div>
					</form>
        </validation-observer>
      </div>
    </div>
    <#elseif section = "scripts">
		<script src="${url.resourcesPath}/js/login-password.js"></script>
    </#if>
</@layout.registrationLayout>
