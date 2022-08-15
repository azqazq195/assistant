import axios from 'axios';

export type SignUpRequestDto = {
  username: string;
  email: string;
  password: string;
  passwordCheck: string;
};

export type SignUpResponseDto = {
  name: string;
  email: string;
  createdDate: Date;
  modifiedDate: Date;
};
