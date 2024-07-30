import { AdopcionModel } from "../models/adopcion.model";
import 

export class AdopcionService {
    constructor() {}

    async getAdopciones() {
        const [total, adopciones] = await Promise.all([
            AdopcionModel.countDocuments(),
            AdopcionModel.find()
        ]);
        return { total, adopciones };
    }

    async getAdopcionesById(id: string) {
        const adopciones = await AdopcionModel.findById(id);
        return adopciones;
    }

    async delete(id: string) {
        const adopciones = await AdopcionModel.findByIdAndDelete(id);
        return adopciones;
    }

}