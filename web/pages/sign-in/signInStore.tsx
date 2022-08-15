import create from 'zustand';

interface SignInState {
  showSignUp: boolean;
  setShowSignUp: (show: boolean) => void;
}

export const useStoreSignIn = create<SignInState>((set) => ({
  showSignUp: false,
  setShowSignUp: (show) => set((state) => ({ ...state, showSignUp: show })),
}));
