import mongoose, { Document } from "mongoose";
import { ObjectId } from "mongoose";
//Interfaz para la denuncia
export interface Denuncia extends Document {
    titulo: string; 
    texto: string; 
    labels: string[]; 
    image: string[];
    fechaDenuncia: Date;
    estado: string;
    usuario: ObjectId;
}
//Exporto la definicion del tipo DenunciaRequest para usar en las peticiones HTTP y no tener problemas con las imagenes
export type DenunciaRequest = Pick<
    Denuncia,
    'titulo' | 'texto' | 'labels' | 'fechaDenuncia' | 'estado' | 'usuario' 
> & {
    image: Express.Multer.File[];
};
// Declaro el esquema del modelo de Mongo
const denunciaSchema = new mongoose.Schema<Denuncia>({
    titulo: {
        type: String,
        required: true
    },
    texto: {
        type: String,
        required: true
    },
    labels: [
        {
            type: String
        }
    ],
    image: [
        {
            type: String
        }
    ],
    fechaDenuncia: {
        type: Date,
        required: true
    },
    estado: {
        type: String,
        enum: ['Pendiente','Enviada','En proceso','Resuelta'],
        default: 'Pendiente'
    },
    usuario: {
        type: mongoose.Schema.Types.ObjectId,
            ref: 'User'
    }
},{
    timestamps: true
});
// Configuro el JSON para omitir el '_id'
denunciaSchema.set("toJSON",{
    virtuals: true,
    versionKey: false,
    transform: function (doc, ret, options) {
        delete ret._id;
    },
})
//Exporto el modelo
export const DenunciaModel = mongoose.model('Denuncia',denunciaSchema);