import mongoose, { Document } from "mongoose";
//Interfaz para la denuncia
export interface Donacion extends Document {
    tipo: String; 
    texto: String; 
    monto: Number; 
    cantidad: Number;
    image: String[]; 
    fechaDonacion: Date; 
}
//Exporto la definicion del tipo DonacionRequest para usar en las peticiones HTTP y no tener problemas con las imagenes
export type DonacionRequest = Pick<
Donacion,
 'tipo' | 'texto' | 'monto' | 'cantidad' | 'fechaDonacion'
 > & {
        image: Express.Multer.File[];
    };
// Declaro el esquema del modelo de Mongo
const donacionSchema = new mongoose.Schema<Donacion>({
    tipo: {
        type: String,
        enum: ['Alimento', 'Dinero', 'Otro'],
        default: 'Dinero'
    },
    texto: {
        type: String,
        required: true
    },
    monto: {
        type: Number,
        required: true
    },
    cantidad: {
        type: Number,
        required: true
    },
    image: [
        {
            type: String
        }
    ],
    fechaDonacion: {
        type: Date,
        required: true
    }
    },{
        timestamps: true
    });
// Configuro el JSON para omitir el '_id'
donacionSchema.set("toJSON",{
        virtuals: true,
        versionKey: false,
        transform(doc, ret, options) {
            delete ret._id;
        },
})
//Exporto el modelo
export const DonacionModel = mongoose.model('Donacion', donacionSchema);