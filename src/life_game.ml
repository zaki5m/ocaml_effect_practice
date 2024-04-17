open Effect
open Effect.Deep

type _ Effect.t += Step : unit -> unit Effect.t
type _ Effect.t += Show :unit -> unit Effect.t

type _ Effect.t += LiveSell :(int * int) -> (int * int) Effect.t (*　指定したSellの値とその周りの生存しているSellの数を返す *)

type _ Effect.t += SetSell :(int * int) -> unit Effect.t

type _ Effect.t += MaxX :unit -> int Effect.t
type _ Effect.t += MaxY :unit -> int Effect.t

let print_white = "◻️"
let print_black = "◼️"

let inner_run f () = 
  match_with f () {
    retc = (fun x -> x);
    exnc = (fun e -> raise e);
    effc = (fun  (type b) (eff: b t)-> 
      (match eff with
        | LiveSell (x,y) -> 
          (Some (fun (k: (b,_) continuation) -> 
            continue k (perform (LiveSell (x,y)))
          ))
        | SetSell (x,y) -> 
          (Some (fun (k: (b,_) continuation) -> 
            continue k (perform (SetSell (x,y)))
          ))
        | Step () -> 
          (Some (fun (k: (b,_) continuation) -> 
                let max_x = perform (MaxX ()) in
                let max_y = perform (MaxY ()) in
                let born_and_change_lst = 
                  let rec loop x y = 
                    if x = max_x then
                      []
                    else if y = max_y then
                      loop (x+1) 0
                    else
                      let live_sell, around_live_sell = perform (LiveSell (x,y)) in
                      let is_change = 
                        if live_sell = 0 then
                          if around_live_sell = 3 then
                            true
                          else
                            false
                        else
                          if around_live_sell = 2 || around_live_sell = 3 then
                            false
                          else
                            true
                      in
                      if is_change then
                        (x,y)::(loop x (y+1))
                      else
                        loop x (y+1)
                  in
                  loop 0 0
                in
                List.iter (fun (x,y) -> perform (SetSell (x,y))) born_and_change_lst;
                continue k ()
          ))
        | _ -> None)
    )
  }

let run f max_x max_y = 
  let array = Array.make_matrix max_x max_y 0 in
  match_with (inner_run f) () {
    retc = (fun x -> x);
    exnc = (fun e -> raise e);
    effc = (fun  (type b) (eff: b t)-> 
      (match eff with
        | LiveSell (x,y) -> 
          (Some (fun (k: (b,_) continuation) ->
            let vertical = 
              if (max_x-1) = x then
                array.(x-1).(y)
              else if x = 0 then
                array.(x+1).(y)
              else
                array.(x-1).(y) + array.(x+1).(y)
            in
            let horizontal = 
              if (max_y-1) = y then
                array.(x).(y-1)
              else if y = 0 then
                array.(x).(y+1)
              else
                array.(x).(y-1) + array.(x).(y+1)
            in
            continue k ((vertical+horizontal), array.(x).(y)))
        )
        | SetSell (x,y) -> 
          (Some (fun (k: (b,_) continuation) -> 
            array.(x).(y) <- (array.(x).(y) + 1) mod 2;
            continue k ()
          ))
        | Show () -> 
          (Some (fun (k: (b,_) continuation) -> 
            let output_string = 
              array |> Array.fold_left (fun acc row -> 
                (row |> Array.fold_left (fun acc cell -> 
                  if cell = 0 then
                    acc ^ print_white
                  else
                    acc ^ print_black
                ) acc ) ^ "\n"
              ) ""
            in
            print_string output_string;
            continue k ()))
        | MaxX () -> 
          (Some (fun (k: (b,_) continuation) -> 
            continue k max_x
          ))
        | MaxY () ->
          (Some (fun (k: (b,_) continuation) -> 
            continue k max_y
          ))
        | _ -> None)
    )
  }


let life_game () = 
  let _ = perform (SetSell (2,2)) in
  let _ = perform (SetSell (2,3)) in
  let _ = perform (SetSell (1,2)) in
  let rec loop () = 
    let _ = perform (Show ()) in
    let _ = perform (Step ()) in
    flush stdout;
    Unix.sleepf 0.1;
    print_string "\x1b[2J";
    loop ()
  in
  loop ()

