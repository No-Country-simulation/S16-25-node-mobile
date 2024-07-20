import mongoose, { Document, ObjectId } from "mongoose";

export interface User extends Document {
    nombre: string;
    fechaDeNacimiento: string;
    rol: string;
    telefono: number;
    email: string;
    password: string;
    poseeAnimales: boolean;
    conviveMenores: boolean;
    patio: boolean;
    dimensiones: number;
    direccion: string;
    imagenPerfil: string;
    animales: ObjectId[];
    donaciones: ObjectId[];
    denuncias: ObjectId[];
    calificaciones: ObjectId[];
    token:string;
}

// Defino el tipo UserRequest para manejar las solicitudes HTTP y no tener problemas con la imagen de perfil
export type UserRequest = Pick<
    User,
    'nombre' | 'fechaDeNacimiento' | 'rol' | 'telefono' | 'email' | 'password' | 'poseeAnimales' | 'conviveMenores' | 'patio' | 'dimensiones' | 'direccion' | 'token'
> & {
    imagenPerfil: Express.Multer.File;
};
//Para manejar la edicion del usuario
export type UpdateUser = Partial<UserRequest>

// Declaro el esquema del modelo de Mongo
const userSchema = new mongoose.Schema<User>({
    nombre: {
        type: String,
        required: true,
        //unique: true,
        index: true,
    },
    rol: {
        type: String,
        enum: ['Admin', 'User', 'Gerente'],
        default: 'User'
    }, 
    telefono: {
        type: Number,
        required: true,
        unique: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        //required: true,
    },
    poseeAnimales: {
        type: Boolean,
        default: false,
    },
    conviveMenores: {
        type: Boolean,
        default: false,
    },
    patio: {
        type: Boolean,
        default: false,
    },
    dimensiones: {
        type: Number,
        default: 0
    },
    direccion: {
        type: String,
        required: true,
        unique: true,
    },
    imagenPerfil:{
        type: String,
    },
    animales: [
        {
            type: mongoose.Schema.Types.ObjectId,
                ref: 'Animal'
        }
    ],
    donaciones: [
        {
            type: mongoose.Schema.Types.ObjectId,
                ref: 'Donacion'
        }
    ],
    denuncias: [
        {
            type: mongoose.Schema.Types.ObjectId,
                ref: 'Denuncia'
        }
    ],
    calificaciones: [
        {
            type: mongoose.Schema.Types.ObjectId,
                ref: 'Calificacion'
        }
    ],
    token:{
        type: String
    }
},{
    timestamps: true
});
// Configuro el JSON para omitir el '_id'
userSchema.set("toJSON",{
    virtuals: true,
	versionKey: false,
	transform: function (doc, ret, options) {
		delete ret._id;
	}
})
//pendiente hashear contraseña

//Exporto el modelo
export const UserModel = mongoose.model('User', userSchema);