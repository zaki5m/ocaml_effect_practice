open Effect
open Effect.Shallow

type _ Effect.t += Get : unit -> int Effect.t
type _ Effect.t += Put : int -> unit Effect.t

let run f init = 
  let rec loop : type a r. int -> (a, r) continuation -> a -> r  = 
    fun state k x ->
      continue_with k x {
        retc = (fun x -> x);
        exnc = (fun e -> raise e);
        effc = (fun  (type b) (eff: b Effect.t)-> 
          (match eff with
            | Get () -> (Some ((fun (k: (b,r) continuation) -> loop state k state)))
            | Put x -> (Some ((fun (k: (b,r) continuation) -> loop x k ())))
            | _ -> None))
      }
    in
  loop init f ()

let f () = 
  let x = perform (Get ()) in (* エフェクトの発生 *)
  print_endline (string_of_int x);
  let _ = perform (Put 3) in  (* エフェクトの発生 *)
  let y = perform (Get ()) in 
  print_endline (string_of_int y);
  ()

let _ = run (fiber f) 0 (* fiberはその地点での継続を取る関数 *)
    