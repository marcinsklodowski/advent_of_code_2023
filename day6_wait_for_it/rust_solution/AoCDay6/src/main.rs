fn main() {
    let times = [40, 92, 97, 90];
    let distances = [215, 1064, 1505, 1100];
    let mut records = [0, 0, 0, 0];

    for race_number in 0..times.len() {
        for try_time in 0..times[race_number] {
            if (times[race_number] - try_time) * try_time > distances[race_number] {
                records[race_number] += 1;
            }
        }
    }

    let mut total = 1;
    for record in records.iter() {
        total *= record;
    }
    println!("Result: {}", total);
}
