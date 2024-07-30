import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { envs } from "../config/envs";
import { User, UserModel } from "../models/user.model";
import { CustomError } from "../utils/custom.error";
import { handleUpload } from "../utils/imageUpload";

const JWT_SECRET = envs.JWT_SEED;

/* if (!JWT_SECRET) {
    throw new Error('JWT_SEED no esta definido');
} */

export class AuthService {

    constructor() {}

    async register(data: any): Promise<{  message: string}> {

        const userExists = await UserModel.findOne({ email: data.email });
        if (userExists) {
            throw CustomError.badRequest('El usuario ya existe');
        }
        
        const hashedPassword = await bcrypt.hash(data.password, 10);
        data.password = hashedPassword;

        /* const imageUrl = await handleUpload(data.image); */
        const imageUrl = "https://res.cloudinary.com/dcp2ljagc/image/upload/v1721955180/Windows_10_Default_Profile_Picture.svg_gjrap2.png"

		const tempUser = { ...data, rol : "User", imagenPerfil: imageUrl };
        //console.log(data)

        const user = new UserModel(tempUser);
        await user.save();
        
        //const token = jwt.sign({id:user.id, email: user.email, rol: user.rol }, JWT_SECRET, { expiresIn: '1h' });

        return { message: 'Usuario registrado correctamente' };
    }

    async login(email: string, password: string ): Promise<{ token: string , rol: string, id: string }> {
        const user = await UserModel.findOne({ email });
        if (!user) {
            throw CustomError.badRequest('El usuario no existe');
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            throw CustomError.badRequest('Contraseña incorrecta');
        }

        const token = jwt.sign({id:user.id, email: user.email, rol: user.rol }, JWT_SECRET, { expiresIn: '1h' });

        return { token, rol: user.rol, id: user.id };
    }

    async getProfile(id: string) {
        const user = await UserModel.findById(id).select('-password -token -createdAt -updatedAt -__v');
        if (!user) {
            throw CustomError.notFound('El usuario no existe');
        }
        return user;
    }
}