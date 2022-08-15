import axios, { AxiosRequestConfig } from 'axios';
import { sign } from 'crypto';
import { SignUpRequestDto, SignUpResponseDto } from './dto/SignUpDto';

// try catch
const axiosConifg: AxiosRequestConfig = {
  baseURL: 'http://localhost:8080',
  headers: {
    'Content-Type': 'application/json',
    Accept: 'application/json',
  },
  timeout: 30000,
};

const client = axios.create(axiosConifg);

async function basicRequest(request: Promise<SignUpResponseDto>) {
  try {
    return request;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      return error.message;
    }
    return 'An unexpected error occurred';
  }
}
// openapi generator
export async function signUp(
  signUpRequestDto: SignUpRequestDto,
): Promise<SignUpResponseDto> {
  //   const { data, status } = await basicRequest(
  //     await axios.post(
  //       baseUrl + '/api/authentication/signUp',
  //       signUpRequestDto,
  //       header,
  //     ),
  //   );

  basicRequest(signUp(signUpRequestDto));

  console.log('request sign up');
  const response = await client.post(
    '/v1/authentication/signup',
    signUpRequestDto,
  );

  console.log(response.status);
  console.log(JSON.stringify(response.data, null, 4));
  return response.data;
}
