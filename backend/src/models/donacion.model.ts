import mongoose, { Document } from "mongoose";

export interface Donacion extends Document {
    tipo: String; 
    texto: String; 
    monto: Number; 
    cantidad: Number;
    image: String; 
    fechaDonacion: Date; 
}

export type DonacionRequest = Pick<
Donacion,
 'tipo' | 'texto' | 'monto' | 'cantidad' | 'fechaDonacion'
 > & {
        image: Express.Multer.File;
    };

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

    donacionSchema.set("toJSON",{
        virtuals: true,
        versionKey: false,
        transform(doc, ret, options) {
            delete ret._id;
        },
    })

    export const DonacionModel = mongoose.model('Donacion', donacionSchema);