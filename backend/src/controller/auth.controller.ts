import { Response } from "express";
import { AuthService } from "../services/auth.service";
import { CustomError } from "../utils/custom.error";

export class AuthController {
    constructor(private readonly authService: AuthService) {}

    private handleError = (error: unknown, res: Response) => {
        if (error instanceof CustomError) {
            return res.status(error.statusCode).json({ message: error.message });
        } else {
            console.log(`${error}`);
            return res.status(500).json({ error: 'Internal server error' });
        }
    };

    login = (req: any, res: Response) => {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({ message: 'El correo y la contraseña son requeridos' });
        }

        this.authService
            .login(email, password)
            .then(user => res.json(user))
            .catch(error => this.handleError(error, res));
    }

    register = (req: any, res: Response) => {
        const { body } = req;
        body.image = req.file;
        this.authService
            .register(body)
            .then(user => res.status(201).json(user))
            .catch(error => this.handleError(error, res));
    }

    getProfile = (req: any, res: Response) => {
        this.authService
            .getProfile(req.params.id)
            .then(user => res.json(user))
            .catch(error => this.handleError(error, res));
    }
}