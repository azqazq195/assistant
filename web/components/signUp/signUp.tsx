import React, { Fragment, useEffect, useRef, useState } from 'react';
import { useStoreSignIn } from '../../pages/sign-in/signInStore';
import { Input } from '../common/input';
import { Validation } from '../common/validation';
import { Dialog } from '../common/dialog';

interface SignUpFormProps {
  name: string;
  email: string;
  password: string;
  passwordCheck: string;
}

export default function SignUp() {
  const { showSignUp, setShowSignUp } = useStoreSignIn();

  const cancelButtonRef = useRef(null);

  const [formValues, setFormValues] = useState<SignUpFormProps>({
    name: '',
    email: '',
    password: '',
    passwordCheck: '',
  });
  const [formErrors, setFormErrors] = useState<string>('');

  const onChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = event.target;
    setFormValues({ ...formValues, [name]: value });
    validate(formValues);
  };

  const validate = (values: SignUpFormProps) => {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/i;
    if (!values.name) {
      setFormErrors('이름을 입력해 주세요.');
      return;
    }
    if (!values.email) {
      setFormErrors('이메일을 입력해 주세요.');
      return;
    }
    if (!regex.test(values.email)) {
      setFormErrors('이메일 형식이 올바르지 않습니다.');
      return;
    }
    if (!values.password) {
      setFormErrors('비밀번호를 입력해 주세요.');
      return;
    }
    if (values.password != values.passwordCheck) {
      setFormErrors('비밀번호가 다릅니다.');
      return;
    }
    setFormErrors('');
  };

  return (
    <Dialog title="Assistant" show={true} initialFocus={cancelButtonRef}>
      <h1 className="mb-3 text-base font-bold text-gray-500">회원가입</h1>

      <Input
        name="name"
        displayName="이름"
        type="text"
        value={formValues.name}
        onChange={onChange}
      />

      <Input
        name="email"
        displayName="이메일"
        type="email"
        value={formValues.email}
        onChange={onChange}
      />

      <Input
        name="password"
        displayName="비밀번호"
        type="password"
        value={formValues.password}
        onChange={onChange}
      />

      <Input
        name="passwordCheck"
        displayName="비밀번호 확인"
        type="password"
        value={formValues.passwordCheck}
        onChange={onChange}
      />

      <Validation isValid={!formErrors} errorMsg={formErrors} />

      <div className="w-full text-center sm:mt-0 sm:px-4 sm:text-left">
        <div className="mb-10" />
        {/* {showSignUpConfirm ? (
                      <button
                        type="button"
                        className="mb-3 w-full text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg"
                        onClick={() => {
                          signUp({
                            username: username,
                            email: email,
                            password: password,
                            passwordCheck: passwordCheck,
                          });
                        }}
                      >
                        회원가입
                      </button>
                    ) : null} */}
        <button
          type="button"
          className="w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-semibold text-gray-600 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          onClick={() => {
            close();
          }}
          ref={cancelButtonRef}
        >
          취소
        </button>
      </div>
    </Dialog>
  );
}
