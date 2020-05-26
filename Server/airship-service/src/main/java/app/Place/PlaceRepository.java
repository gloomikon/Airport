package app.Place;

import org.springframework.data.repository.CrudRepository;

public interface PlaceRepository extends CrudRepository<Place, Integer> {
    Iterable<Place> findByPlaneId(Integer planeId);
}
