import { DenunciaModel, DenunciaRequest } from "../models/denuncia.model";
import { UserModel } from "../models/user.model";
import { CustomError } from "../utils/custom.error";

export class DenunciaService {
    constructor() {}

    async getDenuncias() {
        const [total, denuncias] = await Promise.all([
            DenunciaModel.countDocuments(),
            DenunciaModel.find().populate('usuario')
        ]);
        return { total, denuncias };
    }

    async getDenunciaById(id: string) {
        const denuncia = await DenunciaModel.findById(id).populate('usuario').select('-createdAt -updatedAt -__v');
        if (!denuncia) {
            throw CustomError.notFound('La denuncia no existe');
        }
        return denuncia;
    }

    async create(data: DenunciaRequest) {
        const [denunciaExists, userExists] = await Promise.all([
            DenunciaModel.findOne({ titulo: data.titulo }),
            UserModel.findOne({nombre : data.usuario})
        ])
        const denuncia = new DenunciaModel(data);
        await denuncia.save();
        return denuncia;
    }
}