import mongoose, { ObjectId } from "mongoose";
import { Document } from "mongoose";

export interface Adopcion extends Document {
    animal: ObjectId;
    user: ObjectId;
    estado: string;
}

export type createAdopcionRequest = Pick<Adopcion, "animal" | "user" | "estado">;

export type updateAdopcionRequest = Partial<createAdopcionRequest>;

const adopcionSchema = new mongoose.Schema({
    animal: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Animal"
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    estado: {
        type: String,
        enum: ['En proceso', 'Aceptada', 'Rechazada'],
        default: 'En proceso'
    }
},
    {
        timestamps: true
    }

);

adopcionSchema.set("toJSON", {
    virtuals: true,
    versionKey: false,
    transform: function (doc, ret, options) {
        delete ret._id;
    },
});

export const AdopcionModel = mongoose.model("Adopcion", adopcionSchema);