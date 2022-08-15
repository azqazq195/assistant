import create from 'zustand';

interface SignUpState {
  username: string;
  setUsername: (name: string) => void;
  email: string;
  setEmail: (email: string) => void;
  password: string;
  setPassword: (password: string) => void;
  passwordCheck: string;
  setPasswordCheck: (passwordCheck: string) => void;
  showErrorMsg: boolean;
  setShowErrorMsg: () => void;
  showSignUpConfirm: boolean;
  setShowSignUpConfirm: () => void;
  clear: () => void;
}

export const useStoreSignUp = create<SignUpState>((set) => ({
  username: '',
  setUsername: (username) => set((state) => ({ ...state, username })),
  email: '',
  setEmail: (email) => set((state) => ({ ...state, email })),
  password: '',
  setPassword: (password) => set((state) => ({ ...state, password })),
  passwordCheck: '',
  setPasswordCheck: (passwordCheck) =>
    set((state) => ({ ...state, passwordCheck })),
  showErrorMsg: false,
  setShowErrorMsg: () =>
    set((state) => ({
      showErrorMsg:
        state.password != '' &&
        state.passwordCheck != '' &&
        state.password != state.passwordCheck,
    })),
  showSignUpConfirm: false,
  setShowSignUpConfirm: () =>
    set((state) => ({
      showSignUpConfirm:
        state.username != '' &&
        state.email != '' &&
        state.password != '' &&
        state.passwordCheck != '' &&
        !state.showErrorMsg,
    })),
  clear: () =>
    set(() => ({
      username: '',
      email: '',
      password: '',
      passwordCheck: '',
      showErrorMsg: false,
      showSignUpConfirm: false,
    })),
}));
