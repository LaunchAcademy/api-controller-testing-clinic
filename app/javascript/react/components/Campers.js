import React, { useState, useEffect } from "react"


const Campers = (props) => {

    const [campers, setCampers] = useState([])

    const [camperName, setCamperName] = useState("")

    const getCampers = async () => {
        const response = await fetch("/api/v1/campers")
        const campersData = await response.json()
        setCampers(campersData)
    }

    useEffect(() => {
        getCampers()
    }, [])

    const camperElements = campers.map((camperObject) => {
        return <li key={camperObject.id}>
            {camperObject.name}
        </li>
    })

    const saveTheCamper = async (event) => {
        event.preventDefault()

        const newCamper = {
            camper: {
                name: camperName,
                campsite_id: 1
            }
        }

        const response = await fetch("/api/v1/campers", {
            method: "POST",
            body: JSON.stringify(newCamper),
            headers: new Headers({
                "Accept": "application/json",
                "Content-Type": "application/json"
            })
        })

        const newCamperData = await response.json()

        setCampers([...campers, newCamperData])
    }

    const trackCamperName = (event) => {
        setCamperName(event.currentTarget.value)
    }

    return (
        <div>
            <h1>The Campers</h1>
            <ul>
                {camperElements}
            </ul>

            <div>
                <form onSubmit={saveTheCamper}>
                    <label>
                        Camper Name: 
                        <input 
                            type="text" 
                            name="name"
                            onChange={trackCamperName}  
                        />
                    </label>

                    <input type="submit"/>
                </form>
            </div>
        </div>
    )
}

export default Campers 