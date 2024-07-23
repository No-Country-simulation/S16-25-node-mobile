import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { envs } from "../config/envs";
import { User, UserModel } from "../models/user.model";
import { CustomError } from "../utils/custom.error";

const JWT_SECRET = envs.JWT_SEED;

/* if (!JWT_SECRET) {
    throw new Error('JWT_SEED no esta definido');
} */

export class AuthService {

    constructor() {}

    async register(data: any): Promise<{ user:User; token: string}> {

        const userExists = await UserModel.findOne({ email: data.email });
        if (userExists) {
            throw CustomError.badRequest('El usuario ya existe');
        }
        
        const hashedPassword = await bcrypt.hash(data.password, 10);
        data.password = hashedPassword;

        const user = new UserModel(data);
        await user.save();
        
        const token = jwt.sign({id:user.id, email: user.email, rol: user.rol }, JWT_SECRET, { expiresIn: '1h' });

        return { user, token };
    }

    async login(email: string, password: string ): Promise<{ user:User; token: string}> {
        const user = await UserModel.findOne({ email });
        if (!user) {
            throw CustomError.badRequest('El usuario no existe');
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            throw CustomError.badRequest('Contraseña incorrecta');
        }

        const token = jwt.sign({id:user.id, email: user.email, rol: user.rol }, JWT_SECRET, { expiresIn: '1h' });

        return { user, token };
    }
}