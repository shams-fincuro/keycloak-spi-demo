<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <header>
            <h1 class="mb-2">Change your password</h1>
        </header>
        <div id="kc-form">
      <div id="kc-form-wrapper">
        <validation-observer
            ref="formularioUpdate"
			v-slot="{invalid}">
            <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
                <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                    readonly="readonly" style="display:none;"/>
                <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

                <Validation-provider
                name="password"
                rules="required|passwordstrength"
                vid="confirmation"
                v-slot="{ errors }"
                class="${properties.kcFormGroupClass!}"
                tag="div">
                    <label for="password-new" class="${properties.kcLabelClass!}">${msg("passwordNew")}*</label>
                    <div class="password-container position-relative">
                        <input :type="showPassword ? 'text' : 'password'" id="password-new" name="password-new" class="${properties.kcInputClass!}"
                            autofocus autocomplete="new-password"
                            aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                            maxlength="${properties.kcInputMaxLength!}"
                            v-model="password"
                        />
                        <span class="see-password" :class="showPassword ? 'active' : ''" @click="showPass('password')">
                            see password
                        </span>
                    </div>
                    <#if messagesPerField.existsError('password')>
                        <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                        </span>
                    </#if>
                    <span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
                        {{ errors[0] }}
                    </span>
                </Validation-provider>

                <Validation-provider
                    name="confirm password"
                    rules="required|passwordstrength|confirmed:confirmation"
                    v-slot="{ errors }"
                    class="${properties.kcFormGroupClass!}"
                    tag="div">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}*</label>
                    <div class="password-container position-relative">
                        <input :type="showPasswordConfirm ? 'text' : 'password'" id="password-confirm" name="password-confirm"
                            class="${properties.kcInputClass!}"
                            autocomplete="new-password"
                            aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                            maxlength="${properties.kcInputMaxLength!}"
                            v-model="passwordConfirm"
                        />
                        <span class="see-password" :class="showPasswordConfirm ? 'active' : ''" @click="showPass('passwordConfirm')">
                            see password
                        </span>
                    </div>
                    <#if messagesPerField.existsError('password-confirm')>
                        <span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                        </span>
                    </#if>
                    <span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
                        {{ errors[0] }}
                    </span>
                </Validation-provider>

                <div class="${properties.kcFormGroupClass!} pt-1">
                    <div id="kc-form-options">
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if isAppInitiatedAction??>
                                <div class="checkbox">
                                    <label><input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked> ${msg("logoutOtherSessions")}</label>
                                </div>
                            </#if>
                        </div>
                    </div>

                    <div id="kc-form-buttons">
                        <#if isAppInitiatedAction??>
                            <input :disabled="invalid" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg('doSubmit')}" />
                            <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                        <#else>
                            <input :disabled="invalid" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg('doSubmit')}" />
                        </#if>
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