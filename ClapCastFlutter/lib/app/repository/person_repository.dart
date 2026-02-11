import 'package:clapcastflutter/app/api/api.dart';
import 'package:clapcastflutter/app/model/person.dart';

final personRepository = _PersonRepository();

class _PersonRepository {
  Future<List<PersonOverview>> getPeopleOverview({String? title}) async {
    try {
      List<PersonOverview> people = [];
      const int pageRange = 20;

      if (title == null) {
        for (int page = 1; page < pageRange; page++) {
          final fetchPeople = await apiCinema.actorService
              .getPeopleOverviewPage(page);
          people.addAll(fetchPeople.personList);
        }
      } else {
        final fetchPeople = await apiCinema.actorService.searchPeopleOverview(
            title);
        people.addAll(fetchPeople.personList);
      }

      var filterPeople = people.where((person) =>
      person.profilePathImage?.isNotEmpty ?? false).toList();
      return filterPeople;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<PersonDetails> getPersonDetails(int personId) async {
    try{
      var person = await apiCinema.actorService.getPersonDetails(personId);
      var credits = await apiCinema.actorService.getPersonMovieCredits(personId);
      person = _mergeDetailsAndCredits(person,credits);
      return person;
    }catch(error){
      throw Exception( error);
    }
  }


  PersonDetails _mergeDetailsAndCredits(PersonDetails person,
      PersonFilmography credits) {
    return PersonDetails(
      id: person.id,
      name: person.name,
      department: person.department,
      biography: person.biography,
      birthday: person.birthday,
      placeOfBirth: person.placeOfBirth,
      popularityRate: person.popularityRate,
      profilePathImage: person.profilePathImage,

      knownForMovies: credits,
    );
  }
}