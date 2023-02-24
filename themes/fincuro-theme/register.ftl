<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','cardNumber','email','username','password','password-confirm', 'mobilePhone', 'postalCode'); section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
				<header class="my-4 pt-3 pb-2 header-margin-mob text-center text-md-left">
					<h1 class="mb-2">Nice to meet you!</h1>
				</header>
				<div id="kc-form">
					<div id="kc-form-wrapper">
						<validation-observer
              ref="formulario"
							v-slot="{invalid}">
							<form ref="registerForm" id="kc-register-form" action="${url.registrationAction}" method="post">
								<Validation-provider
									name="first name"
									rules="required|max:30|alpha"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!}"
									tag="div">
										<label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}*</label>
										<input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName"
														data-first-name="${(register.formData.firstName!'')}"
														aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
														placeholder="e.g. John"
														maxlength="${properties.kcInputMaxLength!}"
														v-model="firstName"
										/>
										<#if messagesPerField.existsError('firstName')>
												<span id="input-error-firstname" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
														${kcSanitize(messagesPerField.get('firstName'))?no_esc}
												</span>
										</#if>
										<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
											{{ errors[0] }}
										</span>
								</Validation-provider>

								<Validation-provider
									name="last name"
									rules="required|max:30|alpha"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!}"
									tag="div">
									<label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}*</label>
									<input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName"
													data-last-name="${(register.formData.lastName!'')}"
													aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
													placeholder="e.g. Doe"
													maxlength="${properties.kcInputMaxLength!}"
													v-model="lastName"
									/>
									<#if messagesPerField.existsError('lastName')>
											<span id="input-error-lastname" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
													${kcSanitize(messagesPerField.get('lastName'))?no_esc}
											</span>
									</#if>
									<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
										{{ errors[0] }}
									</span>
								</Validation-provider>

								<div class="${properties.kcFormGroupClass!}">
									<label class="checkbox-container">${msg("I have a card number")}
										<input type="checkbox" id="hasCardNumber" name="hasCardNumber"
													value="${(register.formData.hasCardNumber!'')}"
													aria-invalid="<#if messagesPerField.existsError('hasCardNumber')>true</#if>"
													v-model="iHaveCardNum">
										<span class="checkmark"></span>
									</label>
									<#if messagesPerField.existsError('hasCardNumber')>
											<span id="input-error-hasCardNumber" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
													${kcSanitize(messagesPerField.get('hasCardNumber'))?no_esc}
											</span>
									</#if>
								</div>

								<Validation-provider
									name="printed card number"
									rules="required|numeric|length:12"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!}"
									tag="div"
									v-if="iHaveCardNum">
									<label for="printedCardNumber" class="${properties.kcLabelClass!}">${msg("Printed Card Number")}</label>
									<input type="text" id="printedCardNumber" class="${properties.kcInputClass!}" name="printedCardNumber"
													data-printed-number="${(register.formData.printedCardNumber!'')}"
													aria-invalid="<#if messagesPerField.existsError('printedCardNumber')>true</#if>"
													placeholder="e.g. 123456789"
													maxlength="${properties.kcInputMaxLength!}"
													v-model="printedCardNumber"
									/>
									<#if messagesPerField.existsError('printedCardNumber')>
											<span id="input-error-printedCardNumber" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
													${kcSanitize(messagesPerField.get('printedCardNumber'))?no_esc}
											</span>
									</#if>  
								<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
										{{ errors[0] }}
									</span>
								</Validation-provider>

								<Validation-provider
									name="email"
									rules="required|email"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!}"
									tag="div">
									<label for="email" class="${properties.kcLabelClass!}">${msg("email")}*</label>
									<input type="text" id="email" class="${properties.kcInputClass!}" name="email"
													data-email="${(register.formData.email!'')}" autocomplete="email"
													aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
													placeholder="e.g. johndoe@mail.com"
													maxlength="${properties.kcEmailMaxLength!}"
													v-model="email"
													@input="emailErrDel"
									/>
									<#if messagesPerField.existsError('email')>
											<span v-if="emailKcErr" id="input-error-email" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
													${kcSanitize(messagesPerField.get('email'))?no_esc}
											</span>
									</#if>
									<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
										{{ errors[0] }}
									</span>
								</Validation-provider>

								<Validation-provider
									name="phone number"
									rules="required|phonenumval|min:10|max:18"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!}"
									tag="div">
									<label for="mobilePhone" class="${properties.kcLabelClass!}">${msg("Phone Number")}*</label>
									<input type="text" id="mobilePhone" class="${properties.kcInputClass!}" name="mobilePhone"
													data-mobilePhone="${(register.formData.mobilePhone!'')}"
													aria-invalid="<#if messagesPerField.existsError('mobilePhone')>true</#if>"
													placeholder="e.g. 1 234 567 8901"
													maxlength="${properties.kcInputMaxLength!}"
													v-model="mobilePhone"
													@input="phoneErrDel"
									/>
									<#if messagesPerField.existsError('mobilePhone')>
											<span v-if="phoneKcErr" id="input-error-mobilePhone" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
													${kcSanitize(messagesPerField.get('mobilePhone'))?no_esc}
											</span>
									</#if>
									<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
										{{ errors[0] }}
									</span>
								</Validation-provider>

								<Validation-provider
									name="ZIP code"
									rules="required|zipcode|min:5|max:10"
									v-slot="{ errors }"
									class="${properties.kcFormGroupClass!}"
									tag="div">
									<label for="postalCode" class="${properties.kcLabelClass!}">${msg("ZIP Code")}*</label>
									<input type="text" id="postalCode" class="${properties.kcInputClass!}" name="postalCode"
													data-postalCode="${(register.formData.postalCode!'')}"
													aria-invalid="<#if messagesPerField.existsError('postalCode')>true</#if>"
													placeholder="e.g. 1234566"
													maxlength="${properties.kcInputMaxLength!}"
													v-model="zipCode"
									/>
									<#if messagesPerField.existsError('postalCode')>
											<span id="input-error-postalCode" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
													${kcSanitize(messagesPerField.get('postalCode'))?no_esc}
											</span>
									</#if>
									<span v-if="errors[0]" class="pf-c-form__helper-text pf-m-error required kc-feedback-text">
										{{ errors[0] }}
									</span>
								</Validation-provider>

								<#if !realm.registrationEmailAsUsername>
										<div class="${properties.kcFormGroupClass!}">  
											<label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
											<input type="text" id="username" class="${properties.kcInputClass!}" name="username"
															value="${(register.formData.username!'')}" autocomplete="username"
															aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
											/>
											<#if messagesPerField.existsError('username')>
													<span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
															${kcSanitize(messagesPerField.get('username'))?no_esc}
													</span>
											</#if>
										</div>
								</#if>

								<#if passwordRequired??>
										<p class="my-4">Set your password and enjoy MyReward$</p>
										<Validation-provider
											name="password"
											rules="required|passwordstrength"
											vid="confirmation"
											v-slot="{ errors }"
											class="${properties.kcFormGroupClass!}"
											tag="div">  
											<label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
											<div class="password-container position-relative">
												<input :type="showPassword ? 'text' : 'password'" id="password" class="${properties.kcInputClass!}" name="password"
																autocomplete="new-password"
																aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
																placeholder="e.g. P4ssw0rd"
																maxlength="${properties.kcInputMaxLength!}"
																v-model="password"
												/>
												<span class="see-password" :class="showPassword ? 'active' : ''" @click="showPass('password')">
													<img src="https://d2q4ijjoy71h8b.cloudfront.net/uploads/9aae3801-1fde-45e0-8194-11f220278376/original/icon-password.svg" alt="see password"/>
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
											<label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
											<div class="password-container position-relative">
												<input :type="showPasswordConfirm ? 'text' : 'password'" id="password-confirm" class="${properties.kcInputClass!}"
																name="password-confirm"
																aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
																placeholder="e.g. P4ssw0rd"
																maxlength="${properties.kcInputMaxLength!}"
																v-model="passwordConfirm"
												/>
												<span class="see-password" :class="showPasswordConfirm ? 'active' : ''" @click="showPass('passwordConfirm')">
													<img src="https://d2q4ijjoy71h8b.cloudfront.net/uploads/9aae3801-1fde-45e0-8194-11f220278376/original/icon-password.svg" alt="see password"/>
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
								</#if>

								<#if recaptchaRequired??>
										<div class="form-group">
											<div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
										</div>
								</#if>

								<div class="${properties.kcFormGroupClass!} pt-1">
										<div id="kc-form-buttons">
												<input
													:disabled="invalid"
													class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
													:class="{'sign-up-disable' : disableSignUp}"
													type="submit"
													@click="sendGTM();disableBtn()"
													value="${msg('Sign up')}"/>
										</div>
										<div id="kc-form-options">
												<div class="${properties.kcFormOptionsWrapperClass!} form-group text-center my-3 pt-3">
														<span class="mb-2 d-block">${msg("If you already have an account")}</span>
														<a href="${url.loginUrl}" class="pf-c-button pf-m-outline pf-m-block btn-lg">${kcSanitize(msg("Sign in"))?no_esc}</a>
												</div>
										</div>
								</div>
						</form>
						</validation-observer>
					</div>
				</div>
		<#elseif section = "scripts">
			<script src="${url.resourcesPath}/js/register.js"></script>
		</#if>
</@layout.registrationLayout>