import axios from "axios";

const API_URL = "http://localhost:8080/api/auth/";

interface SignInProps {
    email: string;
    password: string;
}

class AuthService {
    login(signInProps: SignInProps) {
        return axios
            .post(API_URL + "sign-in", signInProps)
            .then(response => {
                if (response.data.accessToken) {
                    localStorage.setItem("user", JSON.stringify(response.data));
                }
                return response.data;
            })
            .catch(reason => {});
    }

    logout() {
        localStorage.removeItem("user");
    }

    getCurrentUser() {
        const userStr = localStorage.getItem("user");
        if (userStr) return JSON.parse(userStr);
        return null;
    }
}

export default new AuthService();