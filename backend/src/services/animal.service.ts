import {
	AnimalModel,
	createAnimalRequest,
	updateAnimalRequest
} from '../models/animal.model';
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
		const imageUrl = await handleUpload(data.image);

		const tempAnimal = { ...data, image: imageUrl };

		const saveAnimal = new AnimalModel(tempAnimal);
		await saveAnimal.save();

		return saveAnimal;
	}

	async getById(id: string) {
		const findAnimal = await AnimalModel.findById(id);

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

			await AnimalModel.findByIdAndUpdate(id, {
				nombre: data.nombre,
				especie: data.especie,
				edad: data.edad,
				peso: data.peso,
				image: imageUrl,
				estado: data.estado
			});
		} else {
			await AnimalModel.findByIdAndUpdate(id, {
				nombre: data.nombre,
				especie: data.especie,
				edad: data.edad,
				peso: data.peso,
				estado: data.estado
			});
		}

		const animal = await AnimalModel.findById(id);

		return animal;
	}

	async delete(id: string) {
		const findAnimal = await AnimalModel.findById(id);

		if (!findAnimal) {
			throw CustomError.notFound('Animal no encontrado');
		}

		await AnimalModel.deleteOne(findAnimal.id);
	}
}
