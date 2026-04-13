import { describe, it, expect, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { Card } from "../components/Card/Card.bs.js";

describe("Card", () => {
	it("renders children", () => {
		render(<Card.make>Card content</Card.make>);
		expect(screen.getByText("Card content")).toBeInTheDocument();
	});

	it("renders Header, Body, and Footer sub-components", () => {
		render(
			<Card.make>
				<Card.Header.make>Title</Card.Header.make>
				<Card.Body.make>Content</Card.Body.make>
				<Card.Footer.make>Actions</Card.Footer.make>
			</Card.make>,
		);
		expect(screen.getByText("Title")).toBeInTheDocument();
		expect(screen.getByText("Content")).toBeInTheDocument();
		expect(screen.getByText("Actions")).toBeInTheDocument();
	});

	it("calls onClick when interactive", () => {
		const handleClick = vi.fn();
		render(
			<Card.make interactive={true} onClick={handleClick}>
				Clickable
			</Card.make>,
		);
		fireEvent.click(screen.getByText("Clickable"));
		expect(handleClick).toHaveBeenCalledOnce();
	});
});
