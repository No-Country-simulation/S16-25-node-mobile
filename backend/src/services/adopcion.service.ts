import { AdopcionModel, createAdopcionRequest, updateAdopcionRequest } from "../models/adopcion.model";
import { AnimalModel } from "../models/animal.model";
import { UserModel } from "../models/user.model";
import { CustomError } from "../utils/custom.error";

export class AdopcionService {
    constructor() {}

    async getAdopciones() {
        const [total, adopciones] = await Promise.all([
            AdopcionModel.countDocuments(),
            AdopcionModel.find().populate('animal user')
        ]);
        return { total, adopciones };
    }

    async getAdopcionById(id: string) {
        const adopcion = await AdopcionModel.findById(id).populate('animal user').select('-createdAt -updatedAt -__v');
        if (!adopcion) {
            throw CustomError.notFound('La adopcion no existe');
        }
        return adopcion;
    }

    async create(data: createAdopcionRequest) {
        const adopcion = new AdopcionModel(data);
        await adopcion.save();
        await AnimalModel.updateOne({ _id: data.animal },  { adopcion: adopcion.id });
        await UserModel.updateOne({ _id: data.user },  { $push: {animales: adopcion.id} });
        return adopcion;
    }

    async update(id: string, data: updateAdopcionRequest) {
        const adopcion = await AdopcionModel.findByIdAndUpdate(id, data);
        return adopcion;
    }

    async delete(id: string) {
        const adopcion = await AdopcionModel.findById(id);
        if (!adopcion) {
            throw CustomError.notFound('La adopcion no existe');
        }
        await AdopcionModel.findByIdAndDelete(id);
        await AnimalModel.updateOne({ _id: adopcion.animal },  { adopcion: null });
        await UserModel.updateOne({ _id: adopcion.user },  { $pull: {animales: adopcion.id} });
        return adopcion;
    }

}