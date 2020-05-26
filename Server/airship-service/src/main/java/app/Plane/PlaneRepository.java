package app.Plane;

import org.springframework.data.repository.CrudRepository;

public interface PlaneRepository extends CrudRepository<Plane, Integer> {
    Iterable<Plane> findByCompanyId(Integer companyId);
}
