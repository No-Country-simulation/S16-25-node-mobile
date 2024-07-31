import { AdopcionModel } from '../models/adopcion.model';
import {
	AnimalModel,
	createAnimalRequest,
	updateAnimalRequest
} from '../models/animal.model';
import { RefugioModel } from '../models/refugio.model';
import { CustomError } from '../utils/custom.error';
import { handleUpload } from '../utils/imageUpload';

export class AnimalService {
	constructor() {}

	async getAnimals() {
		const [total, animals] = await Promise.all([
			AnimalModel.countDocuments(),
			AnimalModel.find()
		]);

		return { total, animals };
	}

	async create(data: createAnimalRequest) {
		const refugioExists = await RefugioModel.findById(data.refugio);
		if (!refugioExists) {
			throw CustomError.notFound('El refugio no existe');
		}
		const imageUrl = await handleUpload(data.image);

		const tempAnimal = { ...data, image: imageUrl };


		const saveAnimal = new AnimalModel(tempAnimal);
		await saveAnimal.save();
		await RefugioModel.updateOne({ _id: data.refugio }, { $push: { animales: saveAnimal.id } });
		return saveAnimal;
	}

	async getById(id: string) {
		const findAnimal = await AnimalModel.findById(id).populate('refugio adopcion');

		if (!findAnimal) {
			throw CustomError.notFound('Animal no encontrado');
		}

		return findAnimal;
	}

	async update(id: string, data: updateAnimalRequest) {
		const animalExists = await AnimalModel.findById(id);

		if (!animalExists) {
			throw CustomError.notFound('El animal no existe');
		}

		if (data.image) {
			const imageUrl = await handleUpload(data.image);
			const tempAnimal = { ...data, image: imageUrl };
			await AnimalModel.findByIdAndUpdate(id, tempAnimal);
		} else {
			const tempAnimal = { ...data, image: animalExists.image };
			await AnimalModel.findByIdAndUpdate(id, tempAnimal);
			
		}

		const animal = await AnimalModel.findById(id);

		return animal;
	}

	async delete(id: string) {
		const findAnimal = await AnimalModel.findById(id);

		if (!findAnimal) {
			throw CustomError.notFound('Animal no encontrado');
		}
		await RefugioModel.updateOne({ _id: findAnimal.refugio }, { $pull: { animales: findAnimal.id } });
		await AdopcionModel.deleteMany({ animal: findAnimal.id });
		await AnimalModel.deleteOne({ _id: findAnimal.id });
	}
}
