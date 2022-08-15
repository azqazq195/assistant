import { useState } from 'react';
import InputComponent from '../input/inputComponent';

const Test = () => {
  const [password, setPassword] = useState<string>('');
  const onChangePassword = (event: React.ChangeEvent<HTMLInputElement>) => {
    setPassword(event.target.value);
  };

  return (
    <>
      {/* 대충 div */}
      <InputComponent
        name="비밀번호"
        type="password"
        value={password}
        onChange={onChangePassword}
        // valid= ??
      />
      {/* 대충 div */}
    </>
  );
};
export default InputComponent;
