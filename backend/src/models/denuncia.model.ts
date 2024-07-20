import mongoose, { Document } from "mongoose";
import { ObjectId } from "mongoose";

export interface Denuncia extends Document {
    titulo: string; /* (notNull) */
    texto: string; /* (notNull) */
    labels: string; /* (Array)  */
    images: string;/* (Array) */
    fechaDenuncia: Date;/* (notNull) */
    estado: boolean;/* (notNull) */
    usuario: ObjectId;
}

export type DenunciaRequest = Pick<
    Denuncia,
    'titulo' | 'texto' | 'labels' | 'fechaDenuncia' | 'estado' | 'usuario'
>

const denunciaSchema = new mongoose.Schema<Denuncia>({
    titulo: {
        type: String,
        required: true
    }
texto:
labels:
images:
fechaDenuncia:
estado:
usuario:
});
    
