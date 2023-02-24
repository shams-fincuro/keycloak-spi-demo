<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <header>
    <h3 class="text-center heading">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</h3>
    
    </header>
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <#if realm.password>
					<validation-observer
              ref="formularioLogin"
							v-slot="{invalid,untouched}">
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <Validation-provider
									name="email"
									rules="required"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!}"
									tag="div">
                    <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}*<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}*<#else>${msg("email")}*</#if></label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" v-model="username" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled placeholder="e.g. johndoe@mail.com"/>
                    <#else>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
															 placeholder="e.g. johndoe@mail.com"
															 maxlength="${properties.kcEmailMaxLength!}"
															 v-model="username"
                        />

                        <#if messagesPerField.existsError('username','password')>
                            <span v-if="untouched" id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>
                    </#if>
                	<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
										{{ errors[0] }}
									</span>
								</Validation-provider>

                <Validation-provider
									name="password"
									rules="required"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!} position-relative"
									tag="div">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}*</label>
										<div class="password-container position-relative">
											<input tabindex="2"
													id="password" class="${properties.kcInputClass!}" name="password" autocomplete="off"
													:type="showPassword ? 'text' : 'password'"
													aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
													placeholder="e.g. P4ssw0rd"
													maxlength="${properties.kcInputMaxLength!}"
													v-model="password"
											/>
											<span class="see-password" :class="showPassword ? 'active' : ''" @click="showPass('password')">
												<i class="fa fa-eye"></i>
											</span>
										</div>
                	<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
										{{ errors[0] }}
									</span>
								</Validation-provider>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!} text-right">
                    <div id="kc-form-options">
                        <#if realm.rememberMe && !usernameEditDisabled??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </#if>
                        </div>
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a tabindex="4" href="${url.loginResetCredentialsUrl}" class="btn-forgot-password">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>

                  </div>

                  <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} pt-1">
                      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                      <input tabindex="5" @click="sendLoginGTM()" :disabled="invalid" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}"/>
                  </div>

            </form>
						</validation-observer>
        </#if>
        </div>

        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>

    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration" class="form-group text-center my-3 pt-3">
                    <span class="mb-2 d-block">${msg("If you don'''t have an account")}</span>
										<a tabindex="6" href="${url.registrationUrl}" class="pf-c-button pf-m-outline pf-m-block btn-lg">${msg("Sign up")}</a>
                </div>
            </div>
        </#if>
		<#elseif section = "scripts">
			<script src="${url.resourcesPath}/js/login-password.js"></script>
		</#if>
</@layout.registrationLayout>
