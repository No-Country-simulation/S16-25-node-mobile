import mongoose from "mongoose";

export interface Adopcion {
    animal: string;
    user: string;
    estado: string;
}

export type createAdopcionRequest = Pick<Adopcion, "animal" | "user" | "estado">;


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
        enum: ['Pendiente', 'Aceptada', 'Rechazada'],
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

export default mongoose.model<Adopcion>("Adopcion", adopcionSchema)